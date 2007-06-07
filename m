From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Thu, 7 Jun 2007 12:08:04 -0400
Message-ID: <200706071208.04777.rob__17659.830247476$1181232566$gmane$org@landley.net>
References: <20070606225837.654272428@goop.org>
	<200706062147.21225.rob@landley.net> <46676552.4060308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46676552.4060308@zytor.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 06 June 2007 9:54 pm, H. Peter Anvin wrote:
> Rob Landley wrote:
> > On Wednesday 06 June 2007 7:41 pm, H. Peter Anvin wrote:
> >> This makes vmlinux (normally stripped) recoverable from the bzImage file
> >> and so anything that is currently booting vmlinux would be serviced by
> >> this scheme.
> > 
> > Would this make it sane to strip the initramfs image out of vmlinux with 
> > objdump and replace it with another one, or are there offsets resolved 
during 
> > the build that stop that for vmlinux?
> > 
> 
> There probably are offsets resolved during the build.  However, that
> wouldn't be all that hard to fix.  Still, one can argue whether or not
> it is sane under any definition to do this kind of unpacking-repacking
> of ELF files.

Er, make that objcopy, not objdump.

Sane, maybe not.  Something people want to do (and under the mistaken 
assumption I know more about initramfs then they do, have asked me how), yes.  
It always boils down to "do you have a vmlinux image lying around?  Doing 
this with a bzImage _is_ brain surgery", and has yet to get beyond that 
question.  I had about half of a script worked out for this, once...

You can also supply an external initramfs image through the initrd mechanism, 
but this is unpleasant to do with some bootloaders (or lack of bootloaders).  
Plus it doesn't remove the old one, and wasting space makes embedded 
developers itch.

Rob
-- 
The Google cluster became self-aware at 2:14am EDT August 29, 2007...
