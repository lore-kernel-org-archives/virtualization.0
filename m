From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] vhost: cleanups and fixes
Date: Thu, 16 Apr 2020 10:01:51 -0700
Message-ID: <CAHk-=wjduPCAE-sr_XLUdExupiL0bOU5GBfpMd32cqMC-VVxeg@mail.gmail.com>
References: <20200414123606-mutt-send-email-mst@kernel.org>
 <CAHk-=wgVQcD=JJVmowEorHHQSVmSw+vG+Ddc4FATZoTp9mfUmw@mail.gmail.com> <20200416081330-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200416081330-mutt-send-email-mst@kernel.org>
Sender: netdev-owner@vger.kernel.org
Cc: KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ashutosh.dixit@intel.com, Bjorn Andersson <bjorn.andersson@linaro.org>, Markus Elfring <elfring@users.sourceforge.net>, eli@mellanox.com, eperezma@redhat.com, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, hulkci@huawei.com, "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <jasowang@redhat.com>, matej.genci@nutanix.com, Stephen Rothwell <sfr@canb.auug.org.au>, yanaijie@huawei.com, YueHaibing <yuehaibing@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 16, 2020 at 5:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> Well it's all just fallout from

What? No. Half of it seems to be the moving of "struct vring" around
to other headers and stuff.

And then that is done very confusingly too, using two different
structures both called "struct vring".

No way can I pull that kind of craziness as a "fix".

                Linus
