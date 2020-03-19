From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 41/70] x86/sev-es: Add Runtime #VC Exception Handler
Date: Thu, 19 Mar 2020 08:44:03 -0700
Message-ID: <CALCETrW9EYi5dzCKNtKkxM18CC4n5BZxTp1=qQ5qZccwstXjzg@mail.gmail.com>
References: <20200319091407.1481-1-joro@8bytes.org> <20200319091407.1481-42-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-42-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 2:14 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Tom Lendacky <thomas.lendacky@amd.com>
>
> Add the handler for #VC exceptions invoked at runtime.

If I read this correctly, this does not use IST.  If that's true, I
don't see how this can possibly work.  There at least two nasty cases
that come to mind:

1. SYSCALL followed by NMI.  The NMI IRET hack gets to #VC and we
explode.  This is fixable by getting rid of the NMI EFLAGS.TF hack.

2. tools/testing/selftests/x86/mov_ss_trap_64.  User code does MOV
(addr), SS; SYSCALL, where addr has a data breakpoint.  We get #DB
promoted to #VC with no stack.
