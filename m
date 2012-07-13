From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio config access races
Date: Fri, 13 Jul 2012 13:25:15 +0930
Message-ID: <871ukgz55o.fsf__20965.4473852881$1342153143$gmane$org@rustcorp.com.au>
References: <20120712225941.GA9317@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120712225941.GA9317@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 13 Jul 2012 01:59:41 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> It looks like there's a problem in the way virtio config currently
> works: if driver reads config in probe routine, config
> subsequently can change before core sets DRIVER_OK.
> This will not cause an interrupt and so this event is lost.
> Maybe we should document that devices should delay such
> events until after DRIVER_OK?

The device is currently defined to be active from the time we
acknowledge the features (which means we may get a spurious interrupt
before we probe, I think).  We abuse this for virtio_blk for example,
where we add_disk() inside the probe function.

Hmm, the changed interrupt is live from find_vqs, right?  Perhaps we
should leave it to drivers to set that up in the right order.

Thoughts?
Rusty.
