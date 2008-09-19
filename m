From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: dm-ioband + bio-cgroup benchmarks
Date: Fri, 19 Sep 2008 20:31:53 +0900 (JST)
Message-ID: <20080919.203153.183041336.ryov__29310.1419033066$1221824054$gmane$org@valinux.co.jp>
References: <20080918.210418.226794540.ryov@valinux.co.jp>
	<48D36794.6010002@oss.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48D36794.6010002@oss.ntt.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: yoshikawa.takuya@oss.ntt.co.jp
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, xemul@openvz.org, fernando@oss.ntt.co.jp, kamezawa.hiroyu@jp.fujitsu.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Yoshikawa-san,

> When you have time, would you explain me how you succeeded to check the
> time, bandwidth, especially when you did write() tests? Actually, I tried
> similar tests and failed to check the bandwidth correctly. Did you insert
> something in the kernel source?

I'm using our own tool, which issues I/Os in prallel in a specified
period and counts up how many I/Os are issued and how many bytes are
transferred in the period.

I'm also using our own tool for measurement of throughput variation to
see the internal data of dm-ioband. This tool is implemented as a
kernel module.

Thanks,
Ryo Tsuruta
