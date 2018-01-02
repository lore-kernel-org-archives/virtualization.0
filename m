From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] virtio: make VIRTIO a menuconfig to ease disabling it all
Date: Wed, 03 Jan 2018 09:40:08 +1100
Message-ID: <871sj7dgvr.fsf@concordia.ellerman.id.au>
References: <20171209152657.4762-1-vincent.legoll@gmail.com>
	<87tvwkfj2f.fsf@concordia.ellerman.id.au>
	<CAEwRq=pVCUPGq4=JLOHQ4gQE0FC+Fotci8+DR_VupgB1BJJB1w@mail.gmail.com>
	<87h8sjpl2p.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87h8sjpl2p.fsf@concordia.ellerman.id.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vincent Legoll <vincent.legoll@gmail.com>
Cc: virtualization@lists.linux-foundation.org, Linux Kernel ML <linux-kernel@vger.kernel.org>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Michael Ellerman <mpe@ellerman.id.au> writes:

> Vincent Legoll <vincent.legoll@gmail.com> writes:
>
>> Hello,
>>
>> thanks for the help, and sorry for the poor patch,
>>
>> On Thu, Dec 21, 2017 at 11:53 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> This breaks all existing .configs *and* defconfigs that use VIRTIO.
>>>
>>> Please don't do that.
>>>
>>> If you make it default y then everything will continue to work.
>>
>> Do you want me to respin it with the added default ?
>
> Yes please, either that or revert it.

This still seems to be broken.

cheers
