From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH V3 1/2] virtio: introduce methods of sanitizing device
	features
Date: Mon, 17 Nov 2014 10:44:30 +0100
Message-ID: <20141117104430.54362e7d.cornelia.huck@de.ibm.com>
References: <1416215838-21700-1-git-send-email-jasowang@redhat.com>
	<20141117093701.GC20133@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141117093701.GC20133@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 17 Nov 2014 11:37:01 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Nov 17, 2014 at 05:17:17PM +0800, Jason Wang wrote:
> > Buggy host may advertised buggy host features (a usual case is that host
> > advertise a feature whose dependencies were missed). In this case, driver
> > should detect and disable the buggy features by itself.
> > 
> > This patch introduces driver specific sanitize_features() method which is
> > called just before features finalizing to detect and disable buggy features
> > advertised by host.
> > 
> > Virtio-net will be the first user.
> > 
> > Cc: Rusty Russell <rusty@rustcorp.com.au>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Hmm this conflicts with virtio 1.0 work: we drop
> features as bitmap there.

But that's an implementation detail, no? We'll still need a way for the
driver to sanitize features, and I think this interface works just fine.
