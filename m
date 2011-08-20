From: jamal <hadi@cyberus.ca>
Subject: Re: [RFC 0/0] Introducing a generic socket offload framework
Date: Sat, 20 Aug 2011 10:32:35 -0400
Message-ID: <1313850755.1734.724.camel__32027.8625855737$1313900262$gmane$org@mojatatu>
References: <20110818220756.5C93E5C80B@san.sea.corp.google.com>
	<1313758185.16299.43.camel@mojatatu>
	<CAPi7mHp==JPA-0vNZ+xWRzOuJYUxsUL3UY=o=VtMUsB-YcFHwQ@mail.gmail.com>
Reply-To: jhs@mojatatu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPi7mHp==JPA-0vNZ+xWRzOuJYUxsUL3UY=o=VtMUsB-YcFHwQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: San Mehat <san@google.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, miche@google.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, digitaleric@google.com, mikew@google.com, maccarro@google.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2011-08-19 at 07:58 -0700, San Mehat wrote:

> Can you explain a good use-case for SOCK_RAW in this type of
> environment? We were noodling it around locally and couldn't come up
> with one that we needed to support.

One that comes to mind is the case of Samir's app: youd need to handle
some of the apps that ride on top of IP typically using SOCK_RAW
eg ping, OSPF essentially anything on IP that doesnt have transport
built into kernel etc; 

> > Q: If you want this to be transparent to the apps, who/what is doing
> > the tagging of SOCK_HWASSIST? clearly not the app if you dont want to
> > change it.
> 
> The decision of whether to tag a socket or not is made by the 'hardware'

As in some config interface? 

cheers,
jamal
