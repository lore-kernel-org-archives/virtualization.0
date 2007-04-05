From: Roland McGrath <roland@redhat.com>
Subject: Re: [patch 1/2] Relocate VDSO ELF headers to match mapped location
	with COMPAT_VDSO
Date: Thu,  5 Apr 2007 01:14:32 -0700 (PDT)
Message-ID: <20070405081432.4CB82180055@magilla.sf.frob.com>
References: <46149B45.2070502@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: Jeremy Fitzhardinge's message of  Wednesday,
	4 April 2007 23:46:29 -0700 <46149B45.2070502@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Jan Beulich <JBeulich@novell.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

> I did the second patch because I could, and to see if it would provoke
> some comment.  But effectively removing a kernel config option seems
> like a good idea to me.

Well, it provoked me to care whether the first patch the relocation
"really right".


Thanks,
Roland
