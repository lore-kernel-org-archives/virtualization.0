From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] tools/virtio: build fixes for virtio_test
Date: Thu, 13 Feb 2014 12:05:33 +0100
Message-ID: <52FCA6FD.8070109@linux.vnet.ibm.com>
References: <1392100100-28193-1-git-send-email-joel@jms.id.au>
	<20140211065757.GA1879@redhat.com> <87r477eic0.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87r477eic0.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>, Joel Stanley <joel@jms.id.au>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 13/02/14 05:40, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> On Tue, Feb 11, 2014 at 04:58:17PM +1030, Joel Stanley wrote:
>>> Recent changes to drivers/virtio broke compilation for the tests in
>>> tools/virtio. The following patches are build fixes for those changes, as well
>>> as a fix for a typo that would have never built.
>>>
>>> The changes were tested on my amd64 system against 3.14-rc2.
>>
>> Ah, thanks a lot for posting this.
>> I had this fixed in my tree but forgot to send.
>> For the series:
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Rusty, will you pick this up?
>
> Hmm, add added:
>
> Fixes: 53c18c9906441 (virtio_test: verify if virtqueue_kick() succeeded)
> Cc: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
>
> Heinz, you didn't compile test your patch.
>
> Insert angry-Torvalds-face here,
> Rusty.
>
Rusty, yes, I missed to compile the test module.

I'm sorry.

Heinz
