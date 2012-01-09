From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] virtio: console: Serialise control work
Date: Mon, 09 Jan 2012 13:03:59 +1030
Message-ID: <87lipha9k8.fsf@rustcorp.com.au>
References: <cover.1325845993.git.amit.shah@redhat.com>
	<0ee4e2fc77b40f1985391ce3f9b8a2cf3f729324.1325845993.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0ee4e2fc77b40f1985391ce3f9b8a2cf3f729324.1325845993.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>, miche@google.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri,  6 Jan 2012 16:19:07 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> We currently allow multiple instances of the control work handler to run
> in parallel.  This isn't expected to work; serialise access by disabling
> interrupts on new packets from the Host and enable them when all the
> existing ones are consumed.
> 
> Testcase: hot-plug/unplug a port in a loop.  Without this patch, some
> sysfs warnings are seen along with freezes.  With the patch, all works
> fine.

Wait a sec... This might *work*, but it's not correct.  Remember that
disabling callbacks is a hint, and it's cetainly not synchronous.

You need something else to explicitly prevent reentry.

Unapplied,
Rusty.
