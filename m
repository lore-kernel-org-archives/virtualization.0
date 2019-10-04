From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 00/13] vsock: add multi-transports support
Date: Fri, 4 Oct 2019 11:16:05 +0200
Message-ID: <20191004091605.ayed7iqjhurzrdap__622.640962113508$1570180588$gmane$org@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<PU1P153MB0169970A7DD4383F06CDAB60BF9E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169970A7DD4383F06CDAB60BF9E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dexuan Cui <decui@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 04, 2019 at 12:04:46AM +0000, Dexuan Cui wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > Sent: Friday, September 27, 2019 4:27 AM
> >  ...
> > Patch 9 changes the hvs_remote_addr_init(). setting the
> > VMADDR_CID_HOST as remote CID instead of VMADDR_CID_ANY to make
> > the choice of transport to be used work properly.
> > @Dexuan Could this change break anything?
> 
> This patch looks good to me.
> 

Thank you very much for your reviews!

> > @Dexuan please can you test on HyperV that I didn't break anything
> > even without nested VMs?
> 
> I did some quick tests with the 13 patches in a Linux VM (this is not
> a nested VM) on Hyper-V and it looks nothing is broken. :-)
> 

Great :-)

> > I'll try to setup a Windows host where to test the nested VMs
> 
> I suppose you're going to run a Linux VM on a Hyper-V host,
> and the Linux VM itself runs KVM/VmWare so it can create its own child 
> VMs. IMO this is similar to the test "nested KVM ( ..., virtio-transport[L1,L2]"
> you have done.

Yes, I think so. If the Hyper-V transport works well without nested VM,
it should work the same with a nested KVM/VMware.

Thanks,
Stefano
