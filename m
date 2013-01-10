From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: fix two typos
Date: Thu, 10 Jan 2013 11:21:59 +1030
Message-ID: <877gnl3ln4.fsf@rustcorp.com.au>
References: <1357718123-9274-1-git-send-email-akong@redhat.com>
	<20130109090335.GB31050@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130109090335.GB31050@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>, akong@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Wed, Jan 09, 2013 at 03:55:23PM +0800, akong@redhat.com wrote:
>> From: Amos Kong <akong@redhat.com>
>> 
>> VIRTIO_NET_F_VTRL_VQ -> VIRTIO_NET_F_CTRL_VQ
>> VIRTIO_NET_CTRL_MQ is defined to 4 in kernel code
>> 
>> Signed-off-by: Amos Kong <akong@redhat.com>
>> ---
>>  virtio-spec.lyx | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied.

Cheers,
Rusty.
