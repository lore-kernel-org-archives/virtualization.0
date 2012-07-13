From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 1/5] aio: Export symbols and struct kiocb_batch for in
	kernel aio usage
Date: Fri, 13 Jul 2012 09:40:03 +0800
Message-ID: <4FFF7C73.2060707__7501.69405150718$1342143507$gmane$org@redhat.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
	<1342107302-28116-2-git-send-email-asias@redhat.com>
	<1342115416.3021.60.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1342115416.3021.60.camel@dabdike.int.hansenpartnership.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi James,

On 07/13/2012 01:50 AM, James Bottomley wrote:
> On Thu, 2012-07-12 at 23:35 +0800, Asias He wrote:
>> This is useful for people who want to use aio in kernel, e.g. vhost-blk.
>>
>> Signed-off-by: Asias He <asias@redhat.com>
>> ---
>>   fs/aio.c            |   37 ++++++++++++++++++-------------------
>>   include/linux/aio.h |   21 +++++++++++++++++++++
>>   2 files changed, 39 insertions(+), 19 deletions(-)
>
> Um, I think you don't quite understand how aio in the kernel would work;
> it's not as simple as just exporting the interfaces.  There's already a
> (very long) patch set from oracle to do this so loop can use aio:
>
> http://marc.info/?l=linux-fsdevel&m=133312234313122

Oh, I did not see this patch set. Thanks for pointing it out! This bit 
hasn't merged, right? I'd love to use the aio_kernel_() interface if it 
is merged. It will simply vhost-blk. Due to lack of better kernel aio 
interface, we are currently doing io_setup, io_submit, etc. in vhost-blk 
on our own.

-- 
Asias
