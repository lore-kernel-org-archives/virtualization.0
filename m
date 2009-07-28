From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Tue, 28 Jul 2009 10:00:06 -0500
Message-ID: <4A6F1276.50709__34778.8309831687$1248794110$gmane$org@codemonkey.ws>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728140029.GA16067@amd.home.annexia.org>
	<4A6F0FA0.4010101@codemonkey.ws>
	<20090728145557.GI3842@amd.home.annexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090728145557.GI3842@amd.home.annexia.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Richard W.M. Jones wrote:
> On Tue, Jul 28, 2009 at 09:48:00AM -0500, Anthony Liguori wrote:
>   
>> Dave Miller nacked that approach with a sledgehammer instead preferring  
>> that we just use standard TCP/IP which is what led to the current  
>> implementation using slirp.
>>     
>
> I'm aware of that - I just don't think it was a good choice.
>
> [BTW the qemu-devel mailing list seems to be bouncing messages]
>   

I know.  I've reported it to the Savannah admins and am helping them 
track it down.

> Rich.
>
>   

Regards,

Anthony Liguori
