From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PULL] uaccess: fix sparse warning on get/put_user for bitwise
	types
Date: Wed, 14 Jan 2015 23:19:14 +0100
Message-ID: <5209009.XRo9cTX8bb__21550.0944330872$1421274000$gmane$org@wuerfel>
References: <20150114173618.GA12436@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150114173618.GA12436@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-arch@vger.kernel.org, james.hogan@imgtec.com, kvm@vger.kernel.org, deller@gmx.de, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, jcmvbkbc@gmail.com, geert@linux-m68k.org, tglx@linutronix.de, sam@ravnborg.org, davem@davemloft.net, egtvedt@samfundet.no
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 14 January 2015 19:36:18 Michael S. Tsirkin wrote:
> As you asked, here's a pull request.
> This has been in linux-next apparently with no ill effects.
> 
> The following changes since commit 99975cc6ada0d5f2675e83abecae05aba5f437d2:
> 
>   vhost/net: length miscalculation (2015-01-07 12:22:00 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/uaccess_for_upstream
> 
> for you to fetch changes up to 0795cb1b46e7938ed679ccd48f933e75272b30e3:
> 

Pulled into my asm-generic now, thanks!

	Arnd
