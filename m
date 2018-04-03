From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Tue, 3 Apr 2018 10:35:36 -0700
Message-ID: <20180403103536.6ec1450c__33031.7579712302$1522776827$gmane$org@xeon-e3>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
	<1522573990-5242-3-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1522573990-5242-3-git-send-email-si-wei.liu@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, sridhar.samudrala@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Sun,  1 Apr 2018 05:13:09 -0400
Si-Wei Liu <si-wei.liu@oracle.com> wrote:

> Hidden netdevice is not visible to userspace such that
> typical network utilites e.g. ip, ifconfig and et al,
> cannot sense its existence or configure it. Internally
> hidden netdev may associate with an upper level netdev
> that userspace has access to. Although userspace cannot
> manipulate the lower netdev directly, user may control
> or configure the underlying hidden device through the
> upper-level netdev. For identification purpose, the
> kobject for hidden netdev still presents in the sysfs
> hierarchy, however, no uevent message will be generated
> when the sysfs entry is created, modified or destroyed.
> 
> For that end, a separate namescope needs to be carved
> out for IFF_HIDDEN netdevs. As of now netdev name that
> starts with colon i.e. ':' is invalid in userspace,
> since socket ioctls such as SIOCGIFCONF use ':' as the
> separator for ifname. The absence of namescope started
> with ':' can rightly be used as the namescope for
> the kernel-only IFF_HIDDEN netdevs.
> 
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---

I understand the use case. I proposed using . as a prefix before
but that ran into resistance. Using colon seems worse.

Rather than playing with names and all the issues that can cause,
why not make it an attribute flag of the device in netlink.
