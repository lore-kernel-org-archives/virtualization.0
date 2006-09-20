From: Zachary Amsden <zach@vmware.com>
Subject: Re: paravirt_ops xen booting
Date: Tue, 19 Sep 2006 18:45:06 -0700
Message-ID: <45109D22.8020401@vmware.com>
References: <20060920001110.GD7474@sequoia.sous-sol.org>
	<45108BB3.7020306@vmware.com>
	<20060920010226.GG21145@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060920010226.GG21145@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
>> Should we just allow paravirt to disable soft watchdog?  It really =

>> doesn't make a lot of sense for paravirt - it should be the hypervisor's =

>> responsibility, and it can break easily across discontinuous time jumps.
>>     =

>
> Sorry, I meant soft lockup detection.
>   =


So did I  ;)
