From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 13 Aug 2009 09:31:13 +0300
Message-ID: <20090813063113.GA3508__11185.4074094028$1250145190$gmane$org@redhat.com>
References: <cover.1249930169.git.mst@redhat.com>
	<200908121903.22325.arnd@arndb.de>
	<20090812172141.GA29966@redhat.com>
	<200908121959.47222.arnd@arndb.de> <4A8317A3.4030303@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A8317A3.4030303@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 12, 2009 at 02:27:31PM -0500, Anthony Liguori wrote:
> Arnd Bergmann wrote:
>>> As I pointed out earlier, most code in virtio net is asymmetrical: guest
>>> provides buffers, host consumes them.  Possibly, one could use virtio
>>> rings in a symmetrical way, but support of existing guest virtio net
>>> means there's almost no shared code.
>>>     
>>
>> The trick is to swap the virtqueues instead. virtio-net is actually
>> mostly symmetric in just the same way that the physical wires on a
>> twisted pair ethernet are symmetric (I like how that analogy fits).
>>   
>
> It's already been done between two guests.  See  
> http://article.gmane.org/gmane.linux.kernel.virtualization/5423
>
> Regards,
>
> Anthony Liguori

Yes, this works by copying data (see PATCH 5/5).  Another possibility is
page flipping.  Either will kill performance.

-- 
MST
