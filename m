From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] potential integer overflow in
 xenbus_file_write()
Date: Tue, 16 Oct 2012 09:54:23 +0100
Message-ID: <507D3CDF02000078000A1A11@nat28.tlf.novell.com>
References: <20120913160032.GA29082@elgon.mountain>
	<1350296757.18058.21.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350296757.18058.21.camel@zakaz.uk.xensource.com>
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
To: Ian Campbell <Ian.Campbell@citrix.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: xen-devel <xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>>> On 15.10.12 at 12:25, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> On Thu, 2012-09-13 at 19:00 +0300, Dan Carpenter wrote:
>> Hi,
> 
> Thanks Dan. I'm not sure anyone from Xen-land really monitors
> virtualization@. Adding xen-devel and Konrad.
> 
>> 
>> I was reading some code and had a question in xenbus_file_write()
>> 
>> drivers/xen/xenbus/xenbus_dev_frontend.c
>>    461          if ((len + u->len) > sizeof(u->u.buffer)) {
>>                      ^^^^^^^^^^^^
>> Can this addition overflow?
> 
> len is a size_t and u->len is an unsigned int, so I expect so.
> 
>>   Should the test be something like:
>> 
>> 	if (len > sizeof(u->u.buffer) || len + u->len > sizeof(u->u.buffer)) {
> 
> I think that would do it.

Actually, it can remain a single range check:

	if (len > sizeof(u->u.buffer) - u->len) {

because the rest of the code guarantees u->len to be less or
equal to sizeof(u->u.buffer) at all times.

Jan
