From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: VirtIO-MMIO on MMU-less System
Date: Tue, 28 Oct 2014 16:51:44 +0000
Message-ID: <CAFEAcA8C1DCQFzbNkPaPR9TFV=oG63W_DH+9Q=oXvXfEs+oUAA@mail.gmail.com>
References: <544FC762.5060507@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <544FC762.5060507@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christopher Covington <cov@codeaurora.org>
Cc: Pawel Moll <Pawel.Moll@arm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 28 October 2014 16:42, Christopher Covington <cov@codeaurora.org> wrote:
> Just out of curiosity, could VirtIO-MMIO peripherals work on an MMU-less
> system, such as a hypothetical M-flavor QEMU TCG virt machine?

No inherent reason, I think. If you care about M profile emulation
you should be aware that it's not currently very high quality,
though...

-- PMM
