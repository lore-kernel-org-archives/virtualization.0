From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: VirtIO-MMIO on MMU-less System
Date: Tue, 28 Oct 2014 16:48:13 +0000
Message-ID: <1414514893.15353.1.camel@arm.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2014-10-28 at 16:42 +0000, Christopher Covington wrote:
> Just out of curiosity, could VirtIO-MMIO peripherals work on an MMU-less
> system, such as a hypothetical M-flavor QEMU TCG virt machine?

The interface is using physical addresses (or physical page numbers), so
MMU or not - it doesn't care.

Now, whether the existing implementation of the drivers (or host-side
implementation of the virtoo device) would work, that's another
question. I see nothing in virtio-mmio driver that clearly wouldn't
work, but you never know...

Pawel
