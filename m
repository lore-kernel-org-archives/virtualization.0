From: Liu Yuan <namei.unix@gmail.com>
Subject: Re: [PATCH] virtio, ring: Use ALIGN macros in virtio_ring.h
Date: Tue, 26 Apr 2011 15:50:13 +0800
Message-ID: <4DB67935.8050104__34439.9723028348$1303804263$gmane$org@gmail.com>
References: <1303791070-15196-1-git-send-email-namei.unix@gmail.com>
	<20110426074230.GA10364@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110426074230.GA10364@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 04/26/2011 03:42 PM, Michael S. Tsirkin wrote:
> On Tue, Apr 26, 2011 at 12:11:10PM +0800, Liu Yuan wrote:
>> From: Liu Yuan<tailai.ly@taobao.com>
>>
>>
>> Signed-off-by: Liu Yuan<tailai.ly@taobao.com>
> Issue is, these functions are exported to userspace,
> which does not have these macros.
>
Ah, thanks, I should have noticed the '#ifdef __KERNEL__' just below the 
lines I touched.

Thanks,
Yuan
