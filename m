From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH v3 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Fri, 31 Aug 2012 11:36:07 +0200
Message-ID: <50408587.5030603@gmail.com>
References: <1346325718-11151-1-git-send-email-levinsasha928@gmail.com>
	<1346325718-11151-2-git-send-email-levinsasha928@gmail.com>
	<20120830133820.GC21132@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120830133820.GC21132@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: avi@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/30/2012 03:38 PM, Michael S. Tsirkin wrote:
>> +static unsigned int indirect_alloc_thresh = 16;
> Why 16?  Please make is MAX_SG + 1 this makes some sense.

Wouldn't MAX_SG mean we always allocate from the cache? Isn't the memory waste
too big in this case?
