From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] vhost: cleanups and fixes
Date: Thu, 16 Apr 2020 08:20:44 -0400
Message-ID: <20200416081330-mutt-send-email-mst@kernel.org>
References: <20200414123606-mutt-send-email-mst@kernel.org>
 <CAHk-=wgVQcD=JJVmowEorHHQSVmSw+vG+Ddc4FATZoTp9mfUmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAHk-=wgVQcD=JJVmowEorHHQSVmSw+vG+Ddc4FATZoTp9mfUmw@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: hulkci@huawei.com, matej.genci@nutanix.com, KVM list <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Netdev <netdev@vger.kernel.org>, yanaijie@huawei.com, YueHaibing <yuehaibing@huawei.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, ashutosh.dixit@intel.com, eperezma@redhat.com, Andy Shevchenko <andy.shevchenko@gmail.com>, eli@mellanox.com, Stephen Rothwell <sfr@canb.auug.org.au>, Bjorn Andersson <bjorn.andersson@linaro.org>, Markus Elfring <elfring@users.sourceforge.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 15, 2020 at 05:46:33PM -0700, Linus Torvalds wrote:
> On Tue, Apr 14, 2020 at 9:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > virtio: fixes, cleanups
> 
> Looking at this, about 75% of it looks like it should have come in
> during the merge window, not now.
> 
>               Linus

Well it's all just fallout from

	commit 61b89f23f854f458b8e23719978df58260f051ed
	Author: Michael S. Tsirkin <mst@redhat.com>
	Date:   Mon Apr 6 08:42:55 2020 -0400

	    vhost: force spec specified alignment on types

which I didn't know we need until things landed upstream and
people started testing with weird configs.

That forced changes to a header file and the rest followed.

We could just ignore -mabi=apcs-gnu build being broken for this release -
is that preferable? Pls let me know.

-- 
MST
