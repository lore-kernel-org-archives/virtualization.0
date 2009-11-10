From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio: Add memory statistics reporting to the
	balloon driver
Date: Tue, 10 Nov 2009 16:43:38 +0200
Message-ID: <4AF97C1A.2080609__47367.2305503443$1257864269$gmane$org@redhat.com>
References: <1257782838.2835.5.camel@aglitke>	<1257784326.2835.16.camel@aglitke>
	<200911101312.02650.rusty@rustcorp.com.au>
	<4AF97A5E.1070801@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AF97A5E.1070801@codemonkey.ws>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/10/2009 04:36 PM, Anthony Liguori wrote:
>
>> A stats vq might solve this more cleanly?
>
> actual and target are both really just stats.  Had we implemented 
> those with a vq, I'd be inclined to agree with you but since they're 
> implemented in the config space, it seems natural to extend the config 
> space with other stats.
>

There is in fact a difference; actual and target are very rarely 
updated, while the stats are updated very often.  Using a vq means a 
constant number of exits per batch instead of one exit per statistic.  
If the vq is host-driven, it also allows the host to control the update 
frequency dynamically (i.e. stop polling when there is no memory pressure).

-- 
error compiling committee.c: too many arguments to function
