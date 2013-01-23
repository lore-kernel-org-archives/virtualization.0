From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Wed, 23 Jan 2013 12:26:41 +1030
Message-ID: <87y5fk3bmu.fsf@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<50FE49E2.8080703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50FE49E2.8080703@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:

> On 01/17/2013 06:29 PM, Rusty Russell wrote:
>> Getting use of virtio rings correct is tricky, and a recent patch saw
>> an implementation of in-kernel rings (as separate from userspace).
>> 
>> This patch attempts to abstract the business of dealing with the
>> virtio ring layout from the access (userspace or direct); to do this,
>> we use function pointers, which gcc inlines correctly.
>> 
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>> ---
>>  drivers/Makefile             |    2 +-
>>  drivers/vhost/Kconfig        |    8 +
>>  drivers/vhost/Kconfig.tcm    |    1 +
>>  drivers/vhost/Makefile       |    2 +
>>  drivers/vhost/vringh.c       |  818 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/virtio/virtio_ring.c |   33 +-
>>  include/linux/virtio_ring.h  |   57 +++
>
>
> Why vringh_notify_enable_user() and vringh_notify_disable_user() are not
> declared in include/linux/virtio_ring.h? Missed that?

Yes, I did... I've fixed it in my vringh branch, where I'm doing
development from now on.

Thanks!
Rusty.
