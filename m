From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 1/3] Virtualization config cleanup: Select
	CONFIG_PARAVIRT when required
Date: Tue, 25 Sep 2007 06:26:23 +0200
Message-ID: <20070925042623.GM6800__17345.2713214376$1190733721$gmane$org@stusta.de>
References: <1190692688.27805.276.camel@localhost.localdomain>
	<20070925040537.GL6800@stusta.de>
	<1190694003.27805.291.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1190694003.27805.291.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 25, 2007 at 02:20:03PM +1000, Rusty Russell wrote:
> On Tue, 2007-09-25 at 06:05 +0200, Adrian Bunk wrote:
> > depends on !(X86_VISWS || X86_VOYAGER)
> 
> Hmm, if A selects B and B depends on C, does A not depend on C?

No.

> If not, I'll patch this...
> 
> Thanks,
> Rusty.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
