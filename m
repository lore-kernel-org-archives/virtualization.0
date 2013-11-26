From: Christopher Covington <cov@codeaurora.org>
Subject: Re: QEMU dies on any attempt to load a Linux kernel module when using
	a 9P rootfs
Date: Tue, 26 Nov 2013 10:16:54 -0500
Message-ID: <5294BB66.3060608@codeaurora.org>
References: <5293718E.4090508@gentoo.org> <5293C622.4070304@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5293C622.4070304@gentoo.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Richard Yao <ryao@gentoo.org>
Cc: kernel@gentoo.org, v9fs-developer@lists.sourceforge.net, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Richard,

On 11/25/2013 04:50 PM, Richard Yao wrote:
> I figured out the problem. There is zerocopy IO is being done via DMA to
> a buffer allocated with valloc(). Right now, I am running a hack-fix
> locally so I can get some other stuff done first. I will propose a
> proper fix to the list in a few days.

I've also encountered this issue on a non-QEMU simulator and have been
carrying a disable-zero-copy hack for a few months. Let me know if there's
anything I can help with.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
