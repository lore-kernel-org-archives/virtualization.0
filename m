From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: fix typo in comment
Date: Mon, 21 May 2012 10:40:28 +0930
Message-ID: <87aa1249vf.fsf@rustcorp.com.au>
References: <1337481874-3472-1-git-send-email-baozich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1337481874-3472-1-git-send-email-baozich@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chen Baozi <baozich@gmail.com>
Cc: Chen Baozi <chenbaozi@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 20 May 2012 10:44:34 +0800, Chen Baozi <baozich@gmail.com> wrote:
> From: Chen Baozi <chenbaozi@gmail.com>
> 
> - Delete "@request_vqs" and "@free_vqs" comments, since
>   they are no longer in struct virtio_config_ops.
> - According to the macro below, "@val" should be "@v".
> 
> Signed-off-by: Chen Baozi <chenbaozi@gmail.com>

Thanks, applied!

Cheers,
Rusty.
