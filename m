From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Fri, 8 Jun 2007 09:19:58 +0530
Message-ID: <20070608034958.GA10728__32902.1676131108$1181274689$gmane$org@in.ibm.com>
References: <20070606225837.654272428@goop.org>
	<20070606230922.476662240@goop.org>
	<4667462A.2010404@zytor.com> <466749C8.2010700@goop.org>
	<46674C96.7090104@zytor.com> <46674F68.6030100@goop.org>
	<4667547B.8080502@zytor.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4667547B.8080502@zytor.com>
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
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 06, 2007 at 05:42:35PM -0700, H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
> > 
> > Certainly, but much harder to implement.  The ELF parser needs to be
> > prepared to move itself around to get out of the way of the ELF file. 
> > It's a fairly large change from how it works now.
> > 
> 
> It doesn't if we simply declare that a certain chunk of memory is
> available to it, for the case where it runs in the native configuration.
> Since it doesn't have to support *any* ELF file, just the kernel one,
> that's an option.
> 
> On the other hand, I guess with the decompressor/ELF parser being PIC,
> one would simply look for the highest used address, and relocate itself
> above that point.  It's not really all that different from what the
> decompressor does today, except that it knows the address a priori.
> 

One would not know highest used address until ELF headers have been 
parsed. May be it is two step movement. First decompress ELF.gz and 
ELF parser can be at the end of decompressed data. Then it can parse
the ELF headers and move itself out of the ELF header destination memory
and then load the elf segments at appropriate place.

One will have to be little careful while moving ELF parser or while
decompressing the file to a temporary buffer so that we don't stomp over
any other data loaded by boot-loader (like kexec does) or we don't go beyond
the memory bounds which might have been created in the case of using kdump.

Thanks
Vivek
