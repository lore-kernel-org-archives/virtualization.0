From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] Virtualization config cleanup: Select
	CONFIG_PARAVIRT when required
Date: Tue, 25 Sep 2007 14:20:03 +1000
Message-ID: <1190694003.27805.291.camel__8235.18165057084$1190694114$gmane$org@localhost.localdomain>
References: <1190692688.27805.276.camel@localhost.localdomain>
	<20070925040537.GL6800@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070925040537.GL6800@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-09-25 at 06:05 +0200, Adrian Bunk wrote:
> depends on !(X86_VISWS || X86_VOYAGER)

Hmm, if A selects B and B depends on C, does A not depend on C?

If not, I'll patch this...

Thanks,
Rusty.
