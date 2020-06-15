From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/17] spelling.txt: /decriptors/descriptors/
Date: Tue, 16 Jun 2020 00:41:15 +0100
Message-ID: <159226447507.27673.16785893373246037922.b4-ty@kernel.org>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, ath10k@lists.infradead.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-rdma@vger.kernel.org, linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 9 Jun 2020 13:45:53 +0100, Kieran Bingham wrote:
> I wouldn't normally go through spelling fixes, but I caught sight of
> this typo twice, and then foolishly grepped the tree for it, and saw how
> pervasive it was.
> 
> so here I am ... fixing a typo globally... but with an addition in
> scripts/spelling.txt so it shouldn't re-appear ;-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: Fix trivial spelling
      commit: d3f3723387f97118c337689fc73e4199fb4331ce
[2/2] regulator: gpio: Fix trivial spelling
      commit: 1f0b740004f09d2f1b716fd6c2fdca81004ded05

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
