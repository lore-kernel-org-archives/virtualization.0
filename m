From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2 v1] blkdrv: Add queue limits parameters
	for sg block drive
Date: Wed, 22 Aug 2012 09:25:08 +0100
Message-ID: <CAJSP0QXipm60x1K063sE-2M1Lz3Vj+FB5OJ8Ed9bsTxfZGmH8Q@mail.gmail.com>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
	<CAAu8pHvN+mSoqDuug0iODipDMQ7rMPy6FEFbQqhsR5ZS9RQFEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAAu8pHvN+mSoqDuug0iODipDMQ7rMPy6FEFbQqhsR5ZS9RQFEQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Blue Swirl <blauwirbel@gmail.com>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 21, 2012 at 7:31 PM, Blue Swirl <blauwirbel@gmail.com> wrote:
> On Tue, Aug 21, 2012 at 8:23 AM, Cong Meng <mc@linux.vnet.ibm.com> wrote:
>> diff --git a/block_int.h b/block_int.h
>> index d72317f..a9d07a2 100644
>> --- a/block_int.h
>> +++ b/block_int.h
>> @@ -333,6 +333,10 @@ struct BlockDriverState {
>>
>>      /* long-running background operation */
>>      BlockJob *job;
>> +
>> +    unsigned int max_sectors;
>
> With 32 bit ints and even with 4k sector size, the maximum disk size
> would be 16TB which may be soon exceeded by disks on the market.
> Please use 64 bit values, probably also for segment values below.

This doesn't specify device size, it specifies max sectors per I/O
request.  When reviewing, I checked that the Linux kernel also uses
unsigned int for these fields.

Stefan
