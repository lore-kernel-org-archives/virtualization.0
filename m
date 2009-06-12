From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Fri, 12 Jun 2009 12:00:01 -0500
Message-ID: <4A328991.3040006__32834.9964497194$1244826054$gmane$org@codemonkey.ws>
References: <cover.1244192535.git.mst@redhat.com>	
	<20090610145540.GI19375@poweredge.glommer>	
	<20090610150129.GC28601@redhat.com>	
	<200906101624.30659.paul@codesourcery.com>	
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>	
	<20090610192702.GH7416@shareable.org>
	<1244796209.16425.20.camel@blaa>	 <4A326B5C.5010501@codemonkey.ws>
	<1244821292.30522.56.camel@blaa>	 <4A327E4A.7010300@codemonkey.ws>
	<1244825303.26769.19.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1244825303.26769.19.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Mark McLoughlin wrote:
> So, when libvirt creates a guest for the first time, it makes a copy of
> the device tree and continues to use that even if qemu is upgraded.
> That's enough to ensure compat is retained for all built-in devices.
>
> However, in order to retain compat for that SCSI device (e.g. ensuring
> the PCI address doesn't change as other devices are added an removed),
> we're back to the same problem ... either:
>
>   1) Use '-drive file=foo.img,if=scsi,pci_addr=foo'; in order to figure 
>      out what address to use, libvirt would need to query qemu for what 
>      address was originally allocated to device or it would do all the 
>      PCI address allocation itself ... or:
>
>   2) Don't use the command line, instead get a dump of the entire 
>      device tree (including the SCSI device) - if the device is to be 
>      removed or modified in future, libvirt would need to modify the 
>      device tree
>
> The basic problem would be that the command line config would have very
> limited ability to override the device tree config.
>   

After libvirt has done -drive file=foo... it should dump the machine 
config and use that from then on.

To combined to a single thread...
> How do you add a new attribute to the device tree and, when a supplied
> device tree lacking said attribute, distinguish between a device tree
> from an old version of qemu (i.e. use the old default) and a partial
> device tree from the VM manager (i.e. use the new default) ?
>   

Please define "attribute".  I don't follow what you're asking.

>> NB the device tree contains no host configuration information.
>>     
>
> So, it wouldn't e.g. include the path to the image file for a block
> device? That would always be specified on the command line?
>   

No, the IDE definition would contain some sort of symbolic node name.  A 
separate mechanism (either command line or host config file) would then 
link a image file to the symbolic name.

libvirt should really never worry about the machine config file for 
normal things unless it needs to change what devices are exposed to a guest.

Regards,

Anthony Liguori
