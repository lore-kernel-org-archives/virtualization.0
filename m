From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] tools/virtio: add sg_unmark_end to scatterlist.h
Date: Thu, 28 Feb 2013 13:27:34 +1030
Message-ID: <878v69du1s.fsf@rustcorp.com.au>
References: <1361226573-12481-1-git-send-email-rusty@rustcorp.com.au>
	<1361959333-8164-1-git-send-email-gaowanlong@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361959333-8164-1-git-send-email-gaowanlong@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Wanlong Gao <gaowanlong@cn.fujitsu.com> writes:
> Add sg_unmark_end to scatterlist.h to fix compile.
>
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Thanks, I have the same patch in my series, which is in flux, but
can be found in my pending-rebases branch:

https://git.kernel.org/?p=linux/kernel/git/rusty/linux.git;a=shortlog;h=refs/heads/pending-rebases

Cheers,
Rusty.
