From: Andi Kleen <andi@firstfloor.org>
Subject: Re: netlink versus pid namespaces
Date: Fri, 15 Oct 2010 17:23:11 +0200
Message-ID: <20101015152311.GC25620__42090.2399033823$1287156325$gmane$org@basil.fritz.box>
References: <20101015142357.GA29321@basil.fritz.box>
	<20101015151903.GA3487@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20101015151903.GA3487@ms2.inr.ac.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: netdev@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, virtualization@lists.linux-foundation.org, xemul@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 15, 2010 at 07:19:03PM +0400, Alexey Kuznetsov wrote:
> Hello!
> 
> > netlink uses pids (or really tids I hope?) to address sockets
> > associated with processes.
> 
> Not really. It uses port number which is called "pid" occasionally. Bad name.
> Autobind function simply selects tgid of calling process as the first guess.

Thanks for the clarification, Alexey. I guess I should have read more
code :/

-Andi
