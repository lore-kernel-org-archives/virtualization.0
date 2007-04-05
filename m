From: Roland McGrath <roland@redhat.com>
Subject: Re: [patch 1/2] Relocate VDSO ELF headers to match mapped
	location with COMPAT_VDSO
Date: Thu,  5 Apr 2007 01:14:15 -0700 (PDT)
Message-ID: <20070405081415.E59E6180055@magilla.sf.frob.com>
References: <4614BD10.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: Jan Beulich's message of  Thursday,
	5 April 2007 08:10:40 +0100 <4614BD10.76E4.0078.0@novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <jbeulich@novell.com>
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

> In addition to Roland's remarks about missing symbol table relocation, I
> would also assume section headers, if present, should be relocated.

Yes, and also the .symtab as well as .dynsym just in case one ever has one
(though I think they are built stripped now, it's not hard to check sh_type
for SHT_SYMTAB and call the same routine that works from DT_SYMTAB).


Thanks,
Roland
