From: wenchao <wenchaolinux@gmail.com>
Subject: Re: [PATCH] vhost-scsi: return -ENOENT when no matching tcm_vhost_tpg
	found
Date: Wed, 12 Jun 2013 09:39:50 +0800
Message-ID: <51B7D166.3000109@gmail.com>
References: <1369731284-4139-1-git-send-email-wenchaolinux@gmail.com>
	<20130528092539.GA22269@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130528092539.GA22269@hj.localdomain>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org, wenchaolinuxkvm@gmail.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

cc to Greg for 3.9.

> On Tue, May 28, 2013 at 04:54:44PM +0800, Wenchao Xia wrote:
>> ioctl for VHOST_SCSI_SET_ENDPOINT report file exist errori, when I forget
>> to set it correctly in configfs, make user confused. Actually it fail
>> to find a matching one, so change the error value.
>>
>> Signed-off-by: Wenchao Xia <wenchaolinux@gmail.com>
>
> Acked-by: Asias He <asias@redhat.com>
>
> BTW, It would be nice to print more informative info in qemu when wwpn
> is not available as well.
>
>> ---
>>   drivers/vhost/scsi.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>> index 7014202..6325b1d 100644
>> --- a/drivers/vhost/scsi.c
>> +++ b/drivers/vhost/scsi.c
>> @@ -1219,7 +1219,7 @@ static int vhost_scsi_set_endpoint(
>>   		}
>>   		ret = 0;
>>   	} else {
>> -		ret = -EEXIST;
>> +		ret = -ENOENT;
>>   	}
>>
>>   	/*
>> --
>> 1.7.1
>>
>
