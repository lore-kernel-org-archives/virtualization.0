From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv4 6/6] qemu-kvm: vhost-net implementation
Date: Thu, 5 Nov 2009 10:23:41 +0200
Message-ID: <20091105082341.GC5774__29868.20895826$1257409626$gmane$org@redhat.com>
References: <cover.1257200517.git.mst@redhat.com>
	<20091102222433.GG15153@redhat.com>
	<1257380527.30511.677.camel@w-sridhar.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1257380527.30511.677.camel@w-sridhar.beaverton.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>, virtualization@lists.linux-foundation.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 04, 2009 at 04:22:07PM -0800, Sridhar Samudrala wrote:
> On Tue, 2009-11-03 at 00:24 +0200, Michael S. Tsirkin wrote:
> > This adds support for vhost-net virtio kernel backend.
> > 
> > This patch is not intended to being merged yet.
> > I'm posting it for the benefit of people testing
> > the backend.
> > 
> > Usage instructions:
> > vhost currently requires MSI-X support in guest virtio.
> > This means guests kernel version should be >= 2.6.31.
> > 
> > To enable vhost, simply add ",vhost" flag to nic options.
> > Example with tap backend:
> > qemu-system-x86_64 -m 1G disk-c.qcow2 \
> > -net tap,ifname=msttap0,script=/home/mst/ifup,downscript=no \
> >  -net nic,model=virtio,vhost
> > 
> > Example with raw socket backend:
> > ifconfig eth3 promisc
> > qemu-system-x86_64 -m 1G disk-c.qcow2 \
> > -net raw,ifname=eth3 \
> >  -net nic,model=virtio,vhost
> 
> As the vhost is a backend feature, i think the 'vhost' flag should
> be added to the -net tap or -net raw option rather than the -net nic
> which specifies the guest options.
> 
> Thanks
> Sridhar

Yes.

-- 
MST
