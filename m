From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio-net: why not always to set avail->flags to
	VRING_AVAIL_F_NO_INTERRUPT
Date: Thu, 04 Jun 2015 10:43:43 +0930
Message-ID: <87k2vkuvg8.fsf__37525.8330758244$1433383162$gmane$org@rustcorp.com.au>
References: <556E9F87.7030202@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <556E9F87.7030202@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linhaifeng <haifeng.lin@huawei.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Linhaifeng <haifeng.lin@huawei.com> writes:
> Hi,
>
> I'm a newbie and have a question about vring_new_virtqueue function.
>
> Why we set avail->flags to VRING_AVAIL_F_NO_INTERRUPT when no callbacks?
> I think we should set avail->flags to VRING_AVAIL_F_NO_INTERRUPT even if no callbacks.

Hi Linhaifeng,

        Not sure I understand your question, but I'll try to answer.

We don't set VRING_AVAIL_F_NO_INTERRUPT if there's a callback because we
want that callback called.  Otherwise callback will never be used.

Cheers,
Rusty.
