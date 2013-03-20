From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 18/22] virtio_rpmsg_bus: use simplified virtqueue
	accessors.
Date: Thu, 21 Mar 2013 09:58:01 +1030
Message-ID: <87ehf9ps72.fsf@rustcorp.com.au>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
	<1363599293-23065-19-git-send-email-rusty@rustcorp.com.au>
	<CAK=WgbaLO9xmcyevfzfdv6Dx6REmX30PTW4JTaoRKo==BnOEAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK=WgbaLO9xmcyevfzfdv6Dx6REmX30PTW4JTaoRKo==BnOEAQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ohad Ben-Cohen <ohad@wizery.com> writes:
> On Mon, Mar 18, 2013 at 11:34 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> We never add buffers with input and output parts, so use the new accessors.
>>
>> Cc: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> Acked-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks.  Unfortunately, a few hours after I pushed it into virtio-next.

Cheers,
Rusty.
