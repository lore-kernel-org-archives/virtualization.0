From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Mon, 2 May 2011 22:11:48 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481DF5AF@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <6E21E5352C11B742B20C142EB499E0481DD676@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110429164025.GA7698@kroah.com> <20110501154041.GB15210@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF253@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110501160721.GA8195@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF2A0@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110501205315.GC1017@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF543@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110502200012.GA21619@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF56D@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110502213511.GA5641@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110502213511.GA5641@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Monday, May 02, 2011 5:35 PM
> To: KY Srinivasan
> Cc: Greg KH; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
> 
> On Mon, May 02, 2011 at 09:16:36PM +0000, KY Srinivasan wrote:
> > > That assumes libata is a module, which it is not for many popular
> > > distributions.
> > >
> > As long as you can prevent ata_piix from loading, it should be fine.
> 
> Again, this might very well be built in, e.g. take a look at:
> 
> http://pkgs.fedoraproject.org/gitweb/?p=kernel.git;a=blob;f=config-
> generic;h=779415bcc036b922ba92de9c4b15b9da64e9707c;hb=HEAD
> 
> http://gitorious.org/opensuse/kernel-
> source/blobs/master/config/x86_64/default

Good point! For what it is worth, last night I hacked up code
to present the block devices currently managed by the blkvsc
driver as scsi devices. I have still retained the blkvsc driver to
handshake with the host and sert up the channel etc. Rather than
presenting this device as an IDE device to the guest, as you had 
suggested, I am adding this device as a scsi device under the HBA
implemented by the storvsc driver. I have assigned a special channel
number to distinguish these IDE disks, so that on the I/O paths we can 
communicate over the appropriate channels. Given that the host is 
completely oblivious to this arrangement on the guest, I suspect
we don't need to worry about future versions of Windows breaking this.
From, very minimal testing I have done, things appear to work well.
However, the motherboard emulation in Hyper-V requires the boot
device to be an IDE device and other than taking over the IDE majors, I don't
know of a way to prevent the native drivers from taking over the boot device.
On SLES, I had implemented modprobe rules to deal with the issue you had 
mentioned; it is not clear what the general solution might be for this problem if any,
other than changes to the host.

Regards,

K. Y
