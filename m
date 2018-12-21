From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] x86, kbuild: revert macrofying inline assembly code
Date: Fri, 21 Dec 2018 10:44:28 -0800
Message-ID: <87woo23ek3.fsf__8958.31846069104$1545417749$gmane$org@linux.intel.com>
References: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
	(Masahiro Yamada's message of "Sun, 16 Dec 2018 11:50:32 +0900")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Michal Marek <michal.lkml@markovi.net>, Richard Biener <rguenther@suse.de>, Arnd Bergmann <arnd@arndb.de>, Segher Boessenkool <segher@kernel.crashing.org>, linux-kbuild@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Alok Kataria <akataria@vmware.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Revert the following 9 commits:

FWIW the -Wa additional also broke LTO builds because it doesn't really
support -Wa for individual files.

So I'm glad they got reverted.

-Andi
