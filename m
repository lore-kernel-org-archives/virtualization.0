From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] virtio-blk: Add stats VQ to collect information about
	devices
Date: Wed, 17 Aug 2011 16:00:42 -0700
Message-ID: <4E4C481A.5080205__15428.3794611276$1313622166$gmane$org@redhat.com>
References: <1313524071-27250-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1313524071-27250-1-git-send-email-levinsasha928@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/16/2011 12:47 PM, Sasha Levin wrote:
> This patch adds support for an optional stats vq that works similary to the
> stats vq provided by virtio-balloon.
>
> The purpose of this change is to allow collection of statistics about working
> virtio-blk devices to easily analyze performance without having to tap into
> the guest.
>
>

Why can't you get the same info from the host?  i.e. read sectors?

Patches to virtio drivers should be preceded by specification updates so 
that guest driver authors and alternative userspace developers have a 
solid reference.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
