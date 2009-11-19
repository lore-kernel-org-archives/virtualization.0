From: Avi Kivity <avi@redhat.com>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver (V3)
Date: Thu, 19 Nov 2009 17:22:08 +0200
Message-ID: <4B0562A0.7040507@redhat.com>
References: <1258643169.3464.3.camel@aglitke> <1258643945.3464.5.camel@aglitke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1258643945.3464.5.camel@aglitke>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Anthony Liguori <aliguori@us.ibm.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/19/2009 05:19 PM, Adam Litke wrote:
> Rusty and Anthony,
> If I've addressed all outstanding issues, please consider this patch for
> inclusion.  Thanks.
>
> +struct virtio_balloon_stat
> +{
> +	__le16 tag;
> +	__le64 val;
> +};
> +
>    

You're not doing endian conversion in the host?

-- 
error compiling committee.c: too many arguments to function
