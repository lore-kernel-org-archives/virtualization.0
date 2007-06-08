From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Thu, 07 Jun 2007 21:01:45 -0700
Message-ID: <4668D4A9.1000905__46062.6166816384$1181275392$gmane$org@zytor.com>
References: <20070606225837.654272428@goop.org>
	<20070606230922.476662240@goop.org>
	<4667462A.2010404@zytor.com> <466749C8.2010700@goop.org>
	<46674C96.7090104@zytor.com> <46674F68.6030100@goop.org>
	<4667547B.8080502@zytor.com> <20070608034958.GA10728@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070608034958.GA10728@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: vgoyal@in.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Vivek Goyal wrote:
> 
> One would not know highest used address until ELF headers have been 
> parsed. May be it is two step movement. First decompress ELF.gz and 
> ELF parser can be at the end of decompressed data. Then it can parse
> the ELF headers and move itself out of the ELF header destination memory
> and then load the elf segments at appropriate place.
> 
> One will have to be little careful while moving ELF parser or while
> decompressing the file to a temporary buffer so that we don't stomp over
> any other data loaded by boot-loader (like kexec does) or we don't go beyond
> the memory bounds which might have been created in the case of using kdump.
> 

The easiest is probably to decode the ELF headers (which can be done in
O(1) space), relocate, reset the decompressor and restart.

Relocation is currently done in the decompressor, but it could also be
done at the kernel entrypoint, as long as the kernel entrypoint code is
all PIC.

	-hpa
