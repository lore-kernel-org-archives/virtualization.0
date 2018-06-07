From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: [PATCH v3 2/3] x86/asm: add _ASM_ARG* constants for argument
	registers to <asm/asm.h>
Date: Thu, 7 Jun 2018 13:13:56 -0700
Message-ID: <2f7fc4bf-d0fe-0d3a-ffdd-02cc82c83747__16977.7357289151$1528402344$gmane$org@linux.intel.com>
References: <20180607183219.192973-1-ndesaulniers@google.com>
	<20180607183219.192973-3-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180607183219.192973-3-ndesaulniers@google.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nick Desaulniers <ndesaulniers@google.com>, akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de
Cc: kstewart@linuxfoundation.org, linux-efi@vger.kernel.org, brijesh.singh@amd.com, jan.kiszka@siemens.com, will.deacon@arm.com, jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com, manojgupta@google.com, akataria@vmware.com, tweek@google.com, mawilcox@microsoft.com, x86@kernel.org, ghackmann@google.com, mka@chromium.org, geert@linux-m68k.org, rientjes@google.com, aryabinin@virtuozzo.com, thomas.lendacky@amd.com, arnd@arndb.de, linux-kbuild@vger.kernel.org, keescook@google.com, rostedt@goodmis.org, acme@redhat.com, caoj.fnst@cn.fujitsu.com, jpoimboe@redhat.com, sedat.dilek@gmail.com, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, jgross@suse.com, michal.lkml@markovi.net, tstellar@redhat.com, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, astrachan@google.com, mjg59@google.com, pombredanne@nexb.com, jo
List-Id: virtualization@lists.linuxfoundation.org

On 06/07/18 11:32, Nick Desaulniers wrote:
> 
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>

If this was suggested by Sedat, I didn't see that suggestion...

	-hpa
