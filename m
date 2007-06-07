From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Wed, 06 Jun 2007 18:54:26 -0700
Message-ID: <46676552.4060308@zytor.com>
References: <20070606225837.654272428@goop.org>
	<20070606230922.476662240@goop.org> <4667462A.2010404@zytor.com>
	<200706062147.21225.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200706062147.21225.rob@landley.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Landley <rob@landley.net>
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Rob Landley wrote:
> On Wednesday 06 June 2007 7:41 pm, H. Peter Anvin wrote:
>> This makes vmlinux (normally stripped) recoverable from the bzImage file
>> and so anything that is currently booting vmlinux would be serviced by
>> this scheme.
> 
> Would this make it sane to strip the initramfs image out of vmlinux with 
> objdump and replace it with another one, or are there offsets resolved during 
> the build that stop that for vmlinux?
> 

There probably are offsets resolved during the build.  However, that
wouldn't be all that hard to fix.  Still, one can argue whether or not
it is sane under any definition to do this kind of unpacking-repacking
of ELF files.

	-hpa
