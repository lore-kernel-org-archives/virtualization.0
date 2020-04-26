From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Subject: Re: [PATCH V2 1/2] vdpa: Support config interrupt in vhost_vdpa
Date: Sun, 26 Apr 2020 15:24:49 +0800
Message-ID: <fb51aa36-9a58-fd50-a4fa-4cc887357367@linux.intel.com>
References: <1587881384-2133-1-git-send-email-lingshan.zhu@intel.com>
 <1587881384-2133-2-git-send-email-lingshan.zhu@intel.com>
 <055fb826-895d-881b-719c-228d0cc9a7bf@redhat.com>
 <e345cc85-aa9d-1173-8308-f0a301fca2b2@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5490650298144481682=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e345cc85-aa9d-1173-8308-f0a301fca2b2@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============5490650298144481682==
Content-Type: multipart/alternative;
 boundary="------------8C42731C34136C49A02C234D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8C42731C34136C49A02C234D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/26/2020 3:03 PM, Jason Wang wrote:
>
> On 2020/4/26 下午2:58, Jason Wang wrote:
>>>
>>> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>>> index 1813821..8663139 100644
>>> --- a/drivers/vhost/vhost.h
>>> +++ b/drivers/vhost/vhost.h
>>> @@ -18,6 +18,8 @@
>>>   typedef void (*vhost_work_fn_t)(struct vhost_work *work);
>>>     #define VHOST_WORK_QUEUED 1
>>> +#define VHOST_FILE_UNBIND -1
>>
>>
>> I think it's better to document this in uapi. 
>
>
> I meant e.g in vhost_vring_file, we had a comment of unbinding:
>
> struct vhost_vring_file {
>     unsigned int index;
>     int fd; /* Pass -1 to unbind from file. */
>
> };

I think it is better to use an int fd than vhost_vring_file, to avoid the confusions,
so if we add#define VHOST_FILE_UNBIND -1 in the uapi header, can it document itself?
Thanks

>
> Thanks
>

--------------8C42731C34136C49A02C234D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><tt><br>
      </tt></p>
    <div class="moz-cite-prefix"><tt>On 4/26/2020 3:03 PM, Jason Wang
        wrote:</tt><tt><br>
      </tt></div>
    <blockquote type="cite"
      cite="mid:e345cc85-aa9d-1173-8308-f0a301fca2b2@redhat.com">
      <tt><br>
      </tt><tt>On 2020/4/26 下午2:58, Jason Wang wrote:
      </tt><tt><br>
      </tt>
      <blockquote type="cite">
        <blockquote type="cite">
          <tt><br>
          </tt><tt>diff --git a/drivers/vhost/vhost.h
            b/drivers/vhost/vhost.h
          </tt><tt><br>
          </tt><tt>index 1813821..8663139 100644
          </tt><tt><br>
          </tt><tt>--- a/drivers/vhost/vhost.h
          </tt><tt><br>
          </tt><tt>+++ b/drivers/vhost/vhost.h
          </tt><tt><br>
          </tt><tt>@@ -18,6 +18,8 @@
          </tt><tt><br>
          </tt><tt>  typedef void (*vhost_work_fn_t)(struct vhost_work
            *work);
          </tt><tt><br>
          </tt><tt>    #define VHOST_WORK_QUEUED 1
          </tt><tt><br>
          </tt><tt>+#define VHOST_FILE_UNBIND -1
          </tt><tt><br>
          </tt></blockquote>
        <tt><br>
        </tt>
        <tt><br>
        </tt><tt>I think it's better to document this in uapi. </tt></blockquote>
      <tt><br>
      </tt>
      <tt><br>
      </tt><tt>I meant e.g in vhost_vring_file, we had a comment of
        unbinding:
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt><tt>struct vhost_vring_file {
      </tt><tt><br>
      </tt><tt>    unsigned int index;
      </tt><tt><br>
      </tt><tt>    int fd; /* Pass -1 to unbind from file. */
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt><tt>};
      </tt><tt><br>
      </tt></blockquote>
    <pre>I think it is better to use an int fd than vhost_vring_file, to avoid the confusions,
so if we add <tt>#define VHOST_FILE_UNBIND -1 in the uapi header, can it document itself?
</tt>
Thanks
</pre>
    <blockquote type="cite"
      cite="mid:e345cc85-aa9d-1173-8308-f0a301fca2b2@redhat.com">
      <tt><br>
      </tt><tt>Thanks
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt>
    </blockquote>
  </body>
</html>

--------------8C42731C34136C49A02C234D--

--===============5490650298144481682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5490650298144481682==--
