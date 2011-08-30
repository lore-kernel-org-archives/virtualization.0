From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: fix size computation according to the definition
	of struct vring_used in vring_size
Date: Tue, 30 Aug 2011 09:42:30 +0930
Message-ID: <87hb4z7o5t.fsf__27727.523193653$1314709519$gmane$org@rustcorp.com.au>
References: <4E584365.1010806@gmail.com> <1314413399.1913.1.camel@Allen>
	<4E58BA41.6050503@gmail.com> <4E58BE42.8030700@gmail.com>
	<87fwkl2ajr.fsf@rustcorp.com.au> <4E5B460F.7070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4E5B460F.7070707@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wang Sheng-Hui <shhuiw@gmail.com>
Cc: wanlong.gao@gmail.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 29 Aug 2011 15:55:59 +0800, Wang Sheng-Hui <shhuiw@gmail.com> wrote:
> Patch regerated to use sizeof(__u16) instead of 16 in vring_init.
> Please check it.

Applied.

Thanks,
Rusty.
