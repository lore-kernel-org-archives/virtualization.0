From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [PATCH 4/7] bio-cgroup: Split the cgroup memory subsystem into
	two parts
Date: Tue, 19 Aug 2008 12:28:11 +0900 (JST)
Message-ID: <20080819.122811.59660409.ryov__31704.8430712477$1219116853$gmane$org@valinux.co.jp>
References: <20080812.213449.104039151.ryov@valinux.co.jp>
	<20080812.213533.189720227.ryov@valinux.co.jp>
	<20080818103938.8b4e8bfa.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080818103938.8b4e8bfa.kamezawa.hiroyu@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kamezawa.hiroyu@jp.fujitsu.com
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, xemul@openvz.org, fernando@oss.ntt.co.jp, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Kamezawa-san,

> I'm now writing remove-lock-page-cgroup patches. it works well.
> please wait for a while...

I'm looking forward to those patches.

By the way, I'm glad if memory-cgroup has a feature which can make a
page_cgroup move between cgroups with small overhead. It makes
bio-cgroup improve the accuracy of tracking down pages.

Thanks,
Ryo Tsuruta
