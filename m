From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-mmio: Fix irq parsing in command line parameter
Date: Thu, 08 Nov 2012 08:52:41 +1030
Message-ID: <87bof93vf2.fsf@rustcorp.com.au>
References: <1352120454.10947.5.camel@hornet>
	<1352120572-16256-1-git-send-email-pawel.moll@arm.com>
	<20121105134413.GC5220@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121105134413.GC5220@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Lee Jones <lee.jones@linaro.org>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Lee Jones <lee.jones@linaro.org> writes:
> On Mon, 05 Nov 2012, Pawel Moll wrote:
>
>> On 64-bit machines resource_size_t is a 64-bit value, while
>> sscanf() format for this argument was defined as "%u". Fixed
>> by using an intermediate local value of a known length.
>> 
>> Also added cleaned up the resource creation and adde extra
>> comments to make the parameters parsing easier to follow.
>> 
>> Reported-by: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
>> ---
>>  drivers/virtio/virtio_mmio.c |   26 ++++++++++++++++++--------
>>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> Resorted to poaching now have we Pawel? ;)

I hope you were joking!  Doing your work for you isn't poaching.

Your correct response was "thanks" followed by 'Tested-by:'.

Cheers,
Rusty.
