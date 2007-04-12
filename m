From: Zachary Amsden <zach@vmware.com>
Subject: Re: paravirt repo rebased to 2.6.21-rc6-mm1
Date: Thu, 12 Apr 2007 08:40:44 -0700
Message-ID: <461E52FC.7070001@vmware.com>
References: <461C1C7B.5080509@goop.org>
	<20070412085430.GD10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070412085430.GD10574@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
>   =

>> Seems to work OK for native and Xen.  I had to play a bit with the
>> paravirt-sched-clock patch to deal with the VMI changes.  Zach, can you
>> check that it still works?
>>     =


I'm working off the same tree as Jeremy, so I'm not seeing any problems =

or failures to apply cleanly. As long as sched_clock units match (cycles =

vs. ns), it should be ok. And even if they are off, it would be very =

hard to tell by observation.

Zach
