From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] memory corruption in HYPERVISOR_physdev_op()
Date: Tue, 16 Oct 2012 10:13:45 +0100
Message-ID: <507D416902000078000A1A57@nat28.tlf.novell.com>
References: <20120914112427.GA1454@elgon.mountain>
	<1350296868.18058.24.camel@zakaz.uk.xensource.com>
	<507D3FDD02000078000A1A2C@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <507D3FDD02000078000A1A2C@nat28.tlf.novell.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Campbell <Ian.Campbell@citrix.com>, Dan Carpenter <dan.carpenter@oracle.com>, Jan Beulich <JBeulich@suse.com>
Cc: Tang Liang <liang.tang@oracle.com>, xen-devel <xen-devel@lists.xen.org>, Jeremy Fitzhardinge <jeremy@xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>>> On 16.10.12 at 11:07, "Jan Beulich" <JBeulich@suse.com> wrote:
>>>> On 15.10.12 at 12:27, Ian Campbell <Ian.Campbell@citrix.com> wrote:
>>> My static analyzer complains about potential memory corruption in
>>> HYPERVISOR_physdev_op()
>>> 
>>> arch/x86/include/asm/xen/hypercall.h
>>>    389  static inline int
>>>    390  HYPERVISOR_physdev_op(int cmd, void *arg)
>>>    391  {
>>>    392          int rc = _hypercall2(int, physdev_op, cmd, arg);
>>>    393          if (unlikely(rc == -ENOSYS)) {
>>>    394                  struct physdev_op op;
>>>    395                  op.cmd = cmd;
>>>    396                  memcpy(&op.u, arg, sizeof(op.u));
>>>    397                  rc = _hypercall1(int, physdev_op_compat, &op);
>>>    398                  memcpy(arg, &op.u, sizeof(op.u));
>>>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> Some of the arg buffers are not as large as sizeof(op.u) which is either
>>> 12 or 16 depending on the size of longs in struct physdev_apic.
>> 
>> Nasty!
> 
> Doesn't the same problem also exist for
> HYPERVISOR_event_channel_op() then, at least theoretically
> (EVTCHNOP_reset is apparently the only addition here so far,
> but is being used by the tools only afaics)?

Actually, the problem isn't tied to new additions of sub-hypercalls
(I was wrongly implying this from the example originally provided),
and should be visible e.g. on any use of EVTCHNOP_unmask.

Jan
