From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] ipv6: Select fragment id during UFO/GSO
	segmentation if not set.
Date: Tue, 27 Jan 2015 00:27:33 -0800 (PST)
Message-ID: <20150127.002733.2208362585040497182.davem__14276.507162913$1422347268$gmane$org@davemloft.net>
References: <1422283026-27832-1-git-send-email-vyasevic@redhat.com>
	<1422283026-27832-2-git-send-email-vyasevic@redhat.com>
	<1422326874.31046.239.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1422326874.31046.239.camel@decadent.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ben@decadent.org.uk
Cc: mst@redhat.com, netdev@vger.kernel.org, vyasevich@gmail.com, virtualization@lists.linux-foundation.org, edumazet@google.com
List-Id: virtualization@lists.linuxfoundation.org

From: Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 27 Jan 2015 02:47:54 +0000

> On Mon, 2015-01-26 at 09:37 -0500, Vladislav Yasevich wrote:
>> If the IPv6 fragment id has not been set and we perform
>> fragmentation due to UFO, select a new fragment id.
>> When we store the fragment id into skb_shinfo, set the bit
>> in the skb so we can re-use the selected id.
>> This preserves the behavior of UFO packets generated on the
>> host and solves the issue of id generation for packet sockets
>> and tap/macvtap devices.
>> 
>> This patch moves ipv6_select_ident() back in to the header file.  
>> It also provides the helper function that sets skb_shinfo() frag
>> id and sets the bit.
>> 
>> It also makes sure that we select the fragment id when doing
>> just gso validation, since it's possible for the packet to
>> come from an untrusted source (VM) and be forwarded through
>> a UFO enabled device which will expect the fragment id.
>> 
>> CC: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>

Applied, thanks Ben.
