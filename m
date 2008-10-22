From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [PATCH 0/2] dm-ioband: I/O bandwidth controller v1.8.0:
	Introduction
Date: Wed, 22 Oct 2008 19:38:31 +0900 (JST)
Message-ID: <20081022.193831.193716981.ryov__29934.5622690909$1224672061$gmane$org@valinux.co.jp>
References: <20081017.160950.71109894.ryov@valinux.co.jp>
	<48FDB8AC.9020707@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48FDB8AC.9020707@windriver.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: zumeng.chen@windriver.com
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, fernando@oss.ntt.co.jp, agk@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Chen,

> I applied your patches(both) into the latest kernel(27), and dm-ioband
> looks work well(other than schedule_timeout in alloc_ioband_device);
> But I think you are the author of bio_tracking, so it is high
> appreciated if you can give your comments and advices for potential
> difference between 27-rc5-mm1 and 2.6.27 to me.

There is no major difference between both version, but I have no time
to port and test bio-cgroup to/on 2.6.27.

Kamezawa-san said
> the newest mmotm has the newest *big* change. enjoy it ;)

The next bio-cgroup patch will be based on this newest change.

Thanks,
Ryo Tsuruta
