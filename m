From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring itself
Date: Sun, 23 May 2010 18:56:05 +0300
Message-ID: <20100523155605.GB14733__4979.04848675734$1274630572$gmane$org@redhat.com>
References: <20100505205814.GA7090@redhat.com> <4BF39C12.7090407@redhat.com>
	<201005201431.51142.rusty@rustcorp.com.au>
	<201005201438.17010.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005201438.17010.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 20, 2010 at 02:38:16PM +0930, Rusty Russell wrote:
> On Thu, 20 May 2010 02:31:50 pm Rusty Russell wrote:
> > On Wed, 19 May 2010 05:36:42 pm Avi Kivity wrote:
> > > > Note that this is a exclusive->shared->exclusive bounce only, too.
> > > >    
> > > 
> > > A bounce is a bounce.
> > 
> > I tried to measure this to show that you were wrong, but I was only able
> > to show that you're right.  How annoying.  Test code below.
> 
> This time for sure!

The share option does not work on some
boxes unless I apply the following:
essentially, this adds mb() after each write
and before read. It seems to make sense to
me: we must update our counter before we
wanit for another side.

diff --git a/cachebounce.c b/cachebounce.c
index 0387027..ebe5a37 100644
--- a/cachebounce.c
+++ b/cachebounce.c
@@ -77,6 +77,7 @@ int main(int argc, char *argv[])
 				count++;
 				counter->cacheline1 = count;
 				count++;
+				__sync_synchronize();
 			}
 			break;
 		case UNSHARE:
@@ -86,6 +87,7 @@ int main(int argc, char *argv[])
 				count++;
 				counter->cacheline2 = count;
 				count++;
+				__sync_synchronize();
 			}
 			break;
 		case LOCKSHARE:
@@ -98,6 +100,7 @@ int main(int argc, char *argv[])
 			break;
 		case LOCKUNSHARE:
 			while (count < MAX_BOUNCES) {
+				__sync_synchronize();
 				/* Spin waiting for other side to change it. */
 				while (counter->cacheline1 != count);
 				__sync_val_compare_and_swap(&counter->cacheline2, count, count+1);
@@ -115,6 +118,7 @@ int main(int argc, char *argv[])
 				count++;
 				counter->cacheline1 = count;
 				count++;
+				__sync_synchronize();
 			}
 			break;
 		case UNSHARE:
@@ -124,6 +128,7 @@ int main(int argc, char *argv[])
 				count++;
 				counter->cacheline1 = count;
 				count++;
+				__sync_synchronize();
 			}
 			break;
 		case LOCKSHARE:
