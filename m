From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH 2/2] vhost_net: a kernel-level virtio server
Date: Wed, 12 Aug 2009 14:27:31 -0500
Message-ID: <4A8317A3.4030303__22033.131219405$1250105427$gmane$org@codemonkey.ws>
References: <cover.1249930169.git.mst@redhat.com>
	<200908121903.22325.arnd@arndb.de>
	<20090812172141.GA29966@redhat.com>
	<200908121959.47222.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200908121959.47222.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
>> As I pointed out earlier, most code in virtio net is asymmetrical: guest
>> provides buffers, host consumes them.  Possibly, one could use virtio
>> rings in a symmetrical way, but support of existing guest virtio net
>> means there's almost no shared code.
>>     
>
> The trick is to swap the virtqueues instead. virtio-net is actually
> mostly symmetric in just the same way that the physical wires on a
> twisted pair ethernet are symmetric (I like how that analogy fits).
>   

It's already been done between two guests.  See 
http://article.gmane.org/gmane.linux.kernel.virtualization/5423

Regards,

Anthony Liguori
